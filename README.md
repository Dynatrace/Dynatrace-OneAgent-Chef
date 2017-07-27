## Overview

This recipe downloads and installs the [Dynatrace](http://www.dynatrace.com/) OneAgent on Linux or Windows systems.

### Sample Usage
####Linux
```
knife ssh 'name:oneagent_test' 'sudo chef-client' --ssh-user user_name
```

### Configuration
Please edit the download_link in attributes according to your needs.

####`download_link`
The link to dynatrace one agent. You can get your link by following these steps

1. go to your dynatrace environment: https://{tenant}.live.dynatrace.com
2. Click the burger menu in the left upper corner and select **Hosts**
3. Click **Monitor another host** button in the right upper corner.
3. You will see the "Download Dynatrace OneAgent" wizard; select  operation system. 
4  For **Linux** 
   -    You will see the **wget** command line. You can copy Your link.
4. For **Windows**
    - Rightclick on "Download agent.exe" button and select "Copy link address"
5. Use the link in your attributes.

## Supported OSes
This recipe is designed for Linux and Windows systems. 
If it does not work for your environment please get in touch via the project site.

##License
This module is provided under BSD-3-Clause license. Please check out the details in the LICENSE.txt
