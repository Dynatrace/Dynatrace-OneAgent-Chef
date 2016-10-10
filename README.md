## Overview

This recipe downloads and installs the [Dynatrace](http://www.dynatrace.com/) OneAgent on linux systems.

### Sample Usage

```
sudo chef-apply dynatrace.rb
```

### Configuration
Please edit the recipe's variables according to your needs.

####`environment`
Your Dynatrace environment ID is the unique identifier of your Dynatrace environment. You can find it easily by looking at the URL in your browser when you are logged into your Dynatrace dashboard.

<code>https://{environment}.live.dynatrace.com</code>

The subdomain {environment} represents your environment id.

####`token`
The token for your Dynatrace environment. You can get your token by following these steps

1. go to your Dynatrace environment: https://{environment}.live.dynatrace.com
2. Click the burger menu in the right upper corner and select **Monitor another host**
3. You will see the "Download Ruxit Agent" wizard; click **Linux**
4. You will see the **wget** command line. The token is the last part of the path after **/latest/**
    
    <code>wget -O dynatrace-OneAgent-Linux-1.XX.0.2017XXXX-XXXXXX.sh https://{environment}.live.dynatrace.com/installer/agent/unix/latest/{this-is-the-token}</code>
5. copy it and use it in your recipe

## Supported OSes
This recipe is designed for Linux systems. 
If it does not work for your environment please get in touch via the project site.

##License
This module is provided under BSD-3-Clause license. Please check out the details in the LICENSE.txt
