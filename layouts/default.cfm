<!DOCTYPE html>
<html lang="en">
    <cfoutput>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Address Book</title>
            <link 
                rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
                integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" 
                crossorigin="anonymous"
                referrerpolicy="no-referrer"
            >
            <link rel="stylesheet" href="./style/style.css">
        </head>
        <body>
            <header>
                <div class="headerItem1">
                    <img src="./Images/Capture.PNG" alt="logo" height="63">
                    <div class="headerItem1Text">
                       ADDRESS BOOK
                    </div>
                </div>
                <div class="headerItem2">
                    <cfif structKeyExists(session,"loginUserId")>
                        <button class="headerItem2_log2 logoutBtn" id="logout">
                            <i class="fa-solid fa-right-from-bracket"></i>
                            <span>Logout</span>
                        </button>
                    <cfelse>
                        <a class="headerItem2_log1" href="index.cfm?action=userAuth.signUp">
                            <i class="fa-solid fa-user"></i>
                            <span>Sign Up</span>
                        </a>
                         <a class="headerItem2_log2" href="index.cfm?action=userAuth.login">
                            <i class="fa-solid fa-right-to-bracket"></i>
                            <span>Login</span>
                        </a>
                    </cfif>
                </div>
            </header>
            #body#
        </body>
    </cfoutput>
</html>