component extends="framework.one" {
    this.datasource = "cf_tutorial";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
    this.applicationTimeout = createTimeSpan(1, 0, 0, 0);
    
    function setupRequest()
    {
       controller("userAuth.checkUserSession")
    }
    
}
