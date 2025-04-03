<cfcomponent >
	<cffunction name="insertUser" access="public" returntype="struct">
		<cfargument name="fullName" required="true" type="string">
		<cfargument name="emailId" required="true" type="string">
		<cfargument name="userName" required="false" type="string">
		<cfargument name="password" required="false"  type="string">
		<cfargument name="profilePhoto" required="true" type="string">
        <cfset  local.result = {
            "success":false,
            "message":""
        }>
		<cfset local.password = hash("#arguments.password#" , "SHA-256" , "UTF-8")>
        <cftry>
			<cfquery name="local.verifyEmailUsername">
			    SELECT count(emailId) as count
			    FROM Users
			    WHERE emailId = <cfqueryparam value = "#arguments.emailId#" cfsqltype = "varchar">
			    OR userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "varchar">
			</cfquery>
			<cfif local.verifyEmailUsername.count GT 0>
				<cfset local.result.message = "email or username already Exist">
			<cfelse>
                <cfset local.uploadDirectory = "C:\ColdFusion2021\cfusion\wwwroot\AddressBookMVC\Images\Uploads">
                <cffile 
                    action="upload"
                    fileField = "profile"
                    destination = "C:\ColdFusion2021\cfusion\wwwroot\AddressBookMVC\Images\Uploads"
                    result="local.newPath"
                    nameconflict="overwrite"
                >
				<cfquery name="local.insertData">
					INSERT INTO Users (
						fullName,
						emailId,
						userName,
						password,
						profilePhoto
							)
					VALUES (
						<cfqueryparam value = '#arguments.fullName#' cfsqltype="varchar">,
						<cfqueryparam value = '#arguments.emailId#' cfsqltype="varchar">,
						<cfqueryparam value = '#arguments.userName#' cfsqltype="varchar">,
						<cfqueryparam value = '#local.password#' cfsqltype="varchar">,
						<cfqueryparam value = '#local.newPath.serverfile#' cfsqltype="varchar">
						)
			    </cfquery>
                <cfset local.result.success = true>
                <cfset local.result.message = "successfully registered">
			</cfif>
		<cfcatch type="any">
            <cfdump var="#cfcatch#">
		</cfcatch>
		</cftry>
            <cfreturn local.result>
	</cffunction>

	<cffunction name="verifyUser" access="public" returntype="struct">
		<cfargument name="userName" type="string" required="true" >
		<cfargument name="password" type="string" required="true">
        <cfset  local.result = {
            "success":false,
            "message":""
        }>
		<cfset local.password = hash("#arguments.password#" , "SHA-256" , "UTF-8")>
		<cfquery name="local.verifyUser">
			SELECT fullName,
					emailId,
					userName,
					password,
					profilePhoto,
					userId
			FROM Users
			WHERE userName = <cfqueryparam value = "#arguments.userName#" cfsqltype = "varchar">
			AND password = <cfqueryparam value = "#local.password#" cfsqltype = "varchar">
		</cfquery>
        <cfif local.verifyUser.recordCount>
            <cfset local.result.success = true>
            <cfset session.loginUserId = local.verifyUser.userId>
            <cfset session.profilePhoto = local.verifyUser.profilePhoto>
            <cfset session.fullName = local.verifyUser.fullName>
            <cfset local.result.message = "login success">
        <cfelse>
            <cfset local.result.message = "Incorrect UserName or Password">
        </cfif>
		<cfreturn local.result>
	</cffunction>

	<cffunction name="verifyEmail" access="public" returntype="query">
		<cfargument name="email" type="string" required="true" >
			<cfquery name = "local.verifyEmail">
				SELECT fullName,
				profilePhoto,
				userName,
				userId
				FROM Users
				WHERE emailId = <cfqueryparam value = "#arguments.email#" cfsqltype = "varchar">
			</cfquery>
		<cfreturn local.verifyEmail>
	</cffunction>
</cfcomponent>