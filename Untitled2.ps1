
    Example 1: Send a web request
    
    PS C:\>$R = Invoke-WebRequest -URI http://www.bing.com?q=how+many+feet+in+a+mile
    PS C:\>$R.AllElements | where {$_.innerhtml -like "*=*"} | Sort { $_.InnerHtml.Length } | Select InnerText -First 5
    innerText---------1 =5280 feet1 mile
    
    This command uses the Invoke-WebRequest cmdlet to send a web request to the Bing.com site.
    
    The first command issues the request and saves the response in the $R variable.
    
    The second command gets the InnerHtml property when it includes an equal sign, sorts the inner HTML by length and selects the 5 shortest values. Sorting by the shortest HTML value often 
    helps you find the most specific element that matches that text.
    Example 2: Use a stateful web service
    
    The first command uses the **Invoke-WebRequest** cmdlet to send a sign-in request. The command specifies a value of "FB" for the value of the *SessionVariable* parameter, and saves the 
    result in the $R variable.When the command completes, the $R variable contains an **HtmlWebResponseObject** and the $FB variable contains a **WebRequestSession** object.
    PS C:\>$R=Invoke-WebRequest http://www.facebook.com/login.php -SessionVariable fb
    
    The second command shows the **WebRequestSession** object in the $FB variable.
    PS C:\>$FB
    
    The third command gets the first form in the **Forms** property of the HTTP response object in the $R variable, and saves it in the $Form variable.
    PS C:\>$Form = $R.Forms[0]
    
    The fourth command pipes the properties of the form in the $Form variable into a list by using the Format-List cmdlet.
    PS C:\>$Form | Format-List
    
    The fifth command displays the keys and values in the hash table (dictionary) object in the Fields property of the form.
    PS C:\>$Form.fields
    
    The sixth and seventh commands populate the values of the email and pass keys of the hash table in the **Fields** property of the form. You can replace the email and password with 
    values that you want to use.
    PS C:\>$Form.Fields["email"]="User01@Fabrikam.com"
    $Form.Fields["pass"]="P@ssw0rd"
    
    The eighth command uses the **Invoke-WebRequest** cmdlet to sign into the Facebook web service.The value of the *Uri* parameter is the value of the **Action** property of the form. The 
    **WebRequestSession** object in the $FB variable (the session variable specified in the first command) is now the value of the *WebSession* parameter. The value of the *Body* parameter 
    is the hash table in the Fields property of the form and the value of the *Method* parameter is POST. The command saves the output in the $R variable.
    PS C:\>$R=Invoke-WebRequest -Uri ("https://www.facebook.com" + $Form.Action) -WebSession $FB -Method POST -Body $Form.Fields
    
    The full script, then, is as follows.
    PS C:\># Sends a sign-in request by running the Invoke-WebRequest cmdlet. The command specifies a value of "fb" for the SessionVariable parameter, and saves the results in the $R 
    variable.
    
    $R=Invoke-WebRequest http://www.facebook.com/login.php -SessionVariable fb
    
    # Use the session variable that you created in Example 1. Output displays values for Headers, Cookies, Credentials, etc. 
    
    $FB
    
    # Gets the first form in the Forms property of the HTTP response object in the $R variable, and saves it in the $Form variable. 
    
    $Form = $R.Forms[0]
    
    # Pipes the form properties that are stored in the $Forms variable into the Format-List cmdlet, to display those properties in a list. 
    
    $Form | Format-List
    
    # Displays the keys and values in the hash table (dictionary) object in the Fields property of the form.
    
    $Form.fields
    
    # The next two commands populate the values of the "email" and "pass" keys of the hash table in the Fields property of the form. Of course, you can replace the email and password with 
    values that you want to use. 
    
    $Form.Fields["email"] = "User01@Fabrikam.com"
    $Form.Fields["pass"] = "P@ssw0rd"
    
    # The final command uses the Invoke-WebRequest cmdlet to sign in to the Facebook web service. 
    
    $R=Invoke-WebRequest -Uri ("https://www.facebook.com" + $Form.Action) -WebSession $FB -Method POST -Body $Form.Fields
    
    When the command finishes, the **StatusDescription** property of the web response object in the $R variable indicates that the user is signed in successfully.
    PS C:\>$R.StatusDescription
    
    This example shows how to use the Invoke-WebRequest cmdlet with a stateful web service, such as Facebook.
    Example 3: Get links from a web page
    
    PS C:\>(Invoke-WebRequest -Uri "http://msdn.microsoft.com/en-us/library/aa973757(v=vs.85).aspx").Links.Href
    
    This command gets the links in a web page. It uses the Invoke-WebRequest cmdlet to get the web page content. Then it users the Links property of the HtmlWebResponseObject that 
    Invoke-WebRequest returns, and the Href property of each link.