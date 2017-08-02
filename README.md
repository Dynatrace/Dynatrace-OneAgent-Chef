# DynatraceOneAgent

## Overview

This recipe downloads and installs the [Dynatrace](http://www.dynatrace.com/) OneAgent on Linux or Windows systems.
To find details about installing OneAgent visit Dynatrace [help page](https://help.dynatrace.com/get-started/installation/how-do-i-install-dynatrace-oneagent/).

### Sample Usage
##### Linux
```
knife ssh 'name:oneagent_test' 'sudo chef-client' --ssh-user user_name
```

### Configuration
Please edit the download_link in attributes according to your needs.

#### `download_link`
The link to dynatrace one agent. You can get your link by following these steps

1. Select **Deploy Dynatrace** from the navigation menu.
2. Click the **Start installation** button.
3  For **Linux** 
   - Locate your `download_link`, as shown below. 
   ![Alt text](https://help.dynatrace.com/images/content/infrastructure-monitoring/containers/openshift-installer.png)
4. For **Windows**
    - Rightclick on "Download agent.exe" button and select "Copy link address"
5. Use the link in your attributes.

## Supported OSes
This recipe is designed for Linux and Windows systems. 
If it does not work for your environment please get in touch via the project site.

## License
This module is provided under BSD-3-Clause license. Please check out the details in the LICENSE.txt
