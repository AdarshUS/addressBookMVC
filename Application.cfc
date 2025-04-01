component extends="framework.one" {
    this.datasource = "cf_tutorial";
    this.sessionManagement = true;

    
    function setupRequest()
    {
       controller("userAuth.checkUserSession")
    }
    
}
