component accessors=true{
    property userService;
    
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
} 