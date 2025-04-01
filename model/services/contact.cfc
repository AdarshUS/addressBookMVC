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
                WHERE _createdBy = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
                AND active = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            </cfquery>
        <cfcatch type="any">
            <cfdump var="#cfcatch#">
        </cfcatch>
        </cftry>
        <cfreturn local.getContacts>
    </cffunction>

    <cffunction name="createContact" access="public" returntype="boolean">
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
        <cftry>
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
                    <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.dateOfBirth#" cfsqltype="cf_sql_date">,
                    <cfqueryparam value="#local.image#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.Address#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.district#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.nationality#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.pinCode#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#session.loginUserId#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#session.loginUserId#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="1" cfsqltype="cf_sql_integer">
                )
            </cfquery>
        <cfcatch type="any">
              <cfoutput>
                  <p>#cfcatch.detail#</p>
              </cfoutput>
              <cfreturn false>
        </cfcatch>
        </cftry>
        <cfreturn true>
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

    <cffunction name="editContact" access="public">
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
            <cfif len(arguments.photo)>
               <cffile 
                    action="upload"
                    fileField = "photo"
                    destination = "C:\ColdFusion2021\cfusion\wwwroot\AddressBookMVC\Images\Uploads"
                    result="local.newPath"
                >
                <cfset local.photo = local.newPath.serverfile>
            <cfelse>
                <cfset local.photo = arguments.hiddenPhoto>
            </cfif>
            <cfset local.todayDate = dateFormat(now(),"dd-mm-yyy")> 
            <cfquery name="local.editContact">
                UPDATE Contact
                SET 
                    title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
                    firstName = <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
                    lastName = <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
                    gender = <cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_varchar">,
                    dateOfBirth = <cfqueryparam value="#arguments.dateOfBirth#" cfsqltype="cf_sql_date">,
                    photo = <cfqueryparam value="#local.photo#" cfsqltype="cf_sql_varchar">,
                    address = <cfqueryparam value="#arguments.address#" cfsqltype="cf_sql_varchar">,
                    street = <cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
                    district = <cfqueryparam value="#arguments.district#" cfsqltype="cf_sql_varchar">,
                    state = <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
                    nationality = <cfqueryparam value="#arguments.nationality#" cfsqltype="cf_sql_varchar">,
                    pinCode = <cfqueryparam value="#arguments.pincode#" cfsqltype="cf_sql_varchar">,
                    emailId = <cfqueryparam value="#arguments.emailId#" cfsqltype="cf_sql_varchar">,
                    phoneNumber = <cfqueryparam value="#arguments.phoneNumber#" cfsqltype="cf_sql_varchar">,
                    _updatedOn = <cfqueryparam value="#local.todayDate#" cfsqltype="cf_sql_date">
                WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">
            </cfquery>
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