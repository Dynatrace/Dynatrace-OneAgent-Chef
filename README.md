## Overview

This recipe downloads and installs the [ruxit](http://www.ruxit.com/) unified agent on linux systems.

### Sample Usage

```
sudo chef-apply ruxit.rb
```

### Configuration
Please edit the recipe's variables according to your needs.

####`tenant`
Your ruxit tenant ID is the unique identifier of your ruxit environment. You can find it easily by looking at the URL in your browser when you are logged into your Ruxit home page.

<code>https://{tenant}.live.ruxit.com</code>

The subdomain {tenant} represents your tenant id.

####`token`
The token for your ruxit tenant. You can get your token by following these steps

1. go to your ruxit environment: https://{tenant}.live.ruxit.com
2. Click the burger menu in the right upper corner and select **Monitor another host**
3. You will see the "Download Ruxit Agent" wizard; click **Linux**
4. You will see the **wget** command line. The token is the last part of the path after **/latest/**
    
    <code>wget -O ruxit-Agent-Linux-1.XX.0.2015XXXX-XXXXXX.sh https://{tenant}.live.ruxit.com/installer/agent/unix/latest/{this-is-the-token}</code>
5. copy it and use it in your recipe

## Supported OSes
This recipe is designed for Linux systems. 
If it does not work for your environment please get in touch via the project site.

##License
This module is provided under BSD-3-Clause license. Please check out the details in the LICENSE.txt
