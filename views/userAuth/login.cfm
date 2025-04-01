<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Address Book</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="./style/style.css">
</head>
<body>
    <cfoutput>
        <main>
        <div class="loginContainer">
            <div class="loginContainer_left">
                <div class="imageContainer">
                    <img src="./Images/Capture.PNG" alt="logo">
                </div>
            </div>
            <div class="loginContainer_right">
                <form method="POST" onsubmit="return validateLogin()">
                    <div class="loginContainer_right-heading">LOGIN</div>
                    <div class="userName inputArea">
                         <input type="text" id="userName" name="userName" placeholder="Username">
                         <div id="userNameErrorLogin" class="error loginError"></div>
                    </div>
                    <div class="password inputArea">
                       <input type="password" name="password" id="password" placeholder="Password">
                       <div id="passwordErrorLogin" class="error loginError">
                       <cfif structKeyExists(rc,"error")>
                            #rc.error#
                       </cfif>
                       </div>
                    </div>
                    <div class="bottomContainer">
                        <button class="loginBtn" id="submit" name="submit">LOGIN</button>
                        <div class="bottomContainerText">Or Sign In Using</div>
                        <div class="imageContainer">
                            <img src="./Images/facebookLogo.png" alt="fb">
                            <a href="./loginSuccess.cfm"><img src="./Images/googleLogo.png" alt="googleLogo" height="48"></a>
                        </div>
                        <div class="registerContainer">Don't have an account? <a href="index.cfm?action=userAuth.signUp">Register Here</a></div>
                    </div>
                </form>
            </div>
        </div>
    </main>
    </cfoutput>
    <script src="./script/script.js"></script>
</body>
</html>