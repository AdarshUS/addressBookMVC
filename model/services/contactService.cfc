<cfcomponent>
   <cffunction name="fetchContacts" access="public" returntype="query">
      <cfargument name="userId" type="string" required="true">
      <cftry>
         <cfquery name="local.getContacts">
            SELECT c.title,
	               c.firstName,
	               c.lastName,
	               c.gender,
	               c.dateOfBirth,
	               c.photo,
	               c.Address,
	               c.street,
	               c.district,
	               c.STATE,
	               c.nationality,
	               c.pinCode,
	               c.emailId,
	               c.phoneNumber,
	               STRING_AGG(r.ROLE, ', ') AS roles
            FROM Contact c
            INNER JOIN contact_roles cr ON c.contactId = cr.contact_id
            INNER JOIN ROLE r ON r.roleId = cr.role_id
            WHERE c._createdBy = <cfqueryparam value="#arguments.userId#" cfsqltype="cf_sql_integer">
            AND   c.active = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
            GROUP BY c.contactId,
	                 c.title,
	                 c.firstName,
	                 c.lastName,
	                 c.gender,
	                 c.dateOfBirth,
	                 c.photo,
	                 c.Address,
	                 c.street,
	                 c.district,
	                 c.STATE,
	                 c.nationality,
	                 c.pinCode,
	                 c.emailId,
	                 c.phoneNumber
         </cfquery>
      <cfcatch type="any">  
         <cfdump var="#cfcatch#">
      </cfcatch>
      </cftry>
      <cfreturn local.getContacts>
   </cffunction>
</cfcomponent>