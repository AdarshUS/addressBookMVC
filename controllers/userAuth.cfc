component accessors=true{
    property userService;
    
    function init( fw ) {
        variables.framework = arguments.fw;
        return this;
    }

    function login(struct rc) {

        if (structKeyExists(rc, "submit")) {
            rc.user = variables.userService.verifyUser(rc.username, rc.password);
            if (rc.user.success) {
                location("index.cfm?action=main");
            } else {
                rc.error = "Invalid email/password";
            }
        }
    }

    function signUp(struct rc)
    {
        if (structKeyExists(rc,"submitbutton")) {

            rc.user = variables.userService.insertUser(
                fullName = rc.fullName,
                emailId = rc.email,
                userName = rc.userName,
                password = rc.password,
                profilePhoto = rc.profile
            );
          /*   if (rc.user.success) {
                variables.fw.redirect("main.default");
            } else {
                rc.error = "Invalid email/password";
            } */
        }
    }

    function logout(struct rc)
    {
        structClear(session);
        location("index.cfm?action=userAuth.login")
    }

    function checkUserSession(struct rc)
    {
        var publicActions = "userAuth.login,userAuth.signUp";
        if (!structKeyExists(session, "loginUserId") && !listFindNoCase(publicActions, rc.action)) {
            variables.framework.redirect("userAuth.login");
        }
    }
} 