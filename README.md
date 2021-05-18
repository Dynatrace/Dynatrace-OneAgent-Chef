# dynatraceoneagent Cookbook

[![Cookbook Version](https://img.shields.io/badge/cookbook-v0.2.0-blue)](https://supermarket.chef.io/cookbooks/dynatraceoneagent)

This cookbook deploys the [Dynatrace OneAgent] on Linux and Windows Operating Systems with different available configurations and ensures the OneAgent service maintains a running state.

## Requirements

- OneAgent version 1.199+
- Dynatrace version 1.204+

### Platforms

- Linux
- Windows

Visit [Supported technologies and versions] for further information about all environments, technologies, and versions that can be monitored with Dynatrace.

### Setup requirements

You will then need to supply the dynatraceoneagent cookbook with two critical pieces of information.

* The Dynatrace environment URL: **Managed** `https://{your-domain}/e/{your-environment-id}` |  **SaaS** `https://{your-environment-id}.live.dynatrace.com`
* The PaaS token of your environment for downloading the OneAgent installer

Refer to the customize OneAgent installation documentation on [Dynatrace Supported Operating Systems].
This module uses the Dynatrace deployment API for downloading the installer for each supported OS. See [Deployment API].

### Chef

- Chef 14+

## Attributes

- `node['dynatraceoneagent']['dynatrace_environment_url']`

  - String. URL of your dynatrace Tenant. Managed `https://{your-domain}/e/{your-environment-id}` - SaaS `https://{your-environment-id}.live.dynatrace.com`, default `nil`.

- `node['dynatraceoneagent']['dynatrace_paas_token']`

  - String. Paas token for downloading the OneAgent installer, default `nil`.

- `node['dynatraceoneagent']['oneagent_version']`

  - String. The required version of the OneAgent in 1.199.247.20200714-111723 format, default `latest`.

- `node['dynatraceoneagent']['oneagent_installer_architecture']`

  - String. The architecture of your OS, default `x86`.

- `node['dynatraceoneagent']['oneagent_installer_type']`

  - String. The type of the installer, default `default`.

- `node['dynatraceoneagent']['oneagent_download_dir']`

  - String. OneAgent installer file download directory - default `Linux /tmp, Windows $TEMP`

- `node['dynatraceoneagent']['verify_installer_signature']`

  - Boolean. Verify OneAgent installer signature (Linux only) - default `true`

- `node['dynatraceoneagent']['oneagent_preserve_installer']`

  - Boolean. Preserve installers on a managed node after deployment, default `true`.

- `node['dynatraceoneagent']['oneagent_install_params_hash']`

  - Hash. Hash map of additional parameters to pass to the installer. Refer to the Customize OneAgent installation documentation on [Dynatrace Supported Operating Systems]. Default `{
  '--set-infra-only'             => 'false',
  '--set-app-log-content-access' => 'true',
}`
- `node['dynatraceoneagent']['oneagent_service_state']`

  - Array. What state the Dynatrace OneAgent service should be in - default `[:enabled, :start]`

- `node['dynatraceoneagent']['oneagent_package_state']`
  - String. What state the dynatrace oneagent package should be in - default `installed` Allowed values: `installed, removed`

<!-- ## Automatically Set Attributes

These attributes are set based on other set attributes, as well as platform / system information provided by Ohai

- `node['dynatraceoneagent']['oneagent_installer_filename']`

  - String. OneAgent installer filename.

- `node['dynatraceoneagent']['dynatrace_deployment_api']`

  - String. Dynatrace deployment API. Default - `/api/v1/deployment/installer/agent`

- `node['dynatraceoneagent']['oneagent_os_type']`

  - String. OS Type used for downloading the OneAgent installer binary.

- `node['dynatraceoneagent']['oneagent_installer_path']`

  - String. File path of OneAgent installer.

- `node['dynatraceoneagent']['dynatrace_root_cert_file_name']`

  - String. Name of the Dynatrace root certificarte file - default `dt-root.cert.pem`

- `node['dynatraceoneagent']['dynatrace_root_cert_path']`

  - String. Path of the Dynatrace root certificate file.

- `node['dynatraceoneagent']['oneagent_certificate_verification_header']`

  - String. OneAgent certificate verification header.

- `node['dynatraceoneagent']['oneagent_ctl_bin_path']`

  - String. Path of oneagentctl binary.

- `node['dynatraceoneagent']['oneagent_service']`

  - String. OneAgent service name.

-->

## Recipes

### default

Include the default recipe in a run list, to get `dynatraceoneagent`.

### oneagent_download

This recipe downloads the OneAgent installer binary.

### oneagent_installer_cleanup

This recipe deletes the OneAgent installer after deployment. On Linux it will also delete the Dynatrace root certificate.

### oneagent_linux_install

Installs the Dynatrace OneAgent on Linux machines, optionally it will also verify the installer signature.

### oneagent_linux_uninstall

Uninstalls the Dynatrace OneAgent on Linux machines.

### oneagent_service

Manages the Dynatrace OneAgent service on both Linux and Windows.

### oneagent_windows_install

Installs the Dynatrace OneAgent on Windows machines.

### oneagent_windows_uninstall

Uninstalls the Dynatrace OneAgent on Windows machines.

## Usage

Set up the `dynatraceoneagent` attributes in a role.

### Roles Examples

#### Most basic OneAgent installation using a SAAS tenant

```ruby
name 'dynatraceoneagent'
description 'Deploy Dynatrace OneAgent'
default_attributes(
  'dynatraceoneagent' => {
    'dynatrace_environment_url' => 'https://{your-environment-id}.live.dynatrace.com',
    'dynatrace_paas_token'      => '{your-paas-token}'
  }
)
run_list(
  'recipe[dynatraceoneagent]'
)
```

#### OneAgent installation using a managed tenant with a specific version

The required version of the OneAgent must be in 1.155.275.20181112-084458 format. See [Deployment API - GET available versions of OneAgent]

```ruby
name 'dynatraceoneagent'
description 'Deploy Dynatrace OneAgent'
default_attributes(
  'dynatraceoneagent' => {
    'dynatrace_environment_url' => 'https://{your-domain}/e/{your-environment-id}',
    'dynatrace_paas_token'      => '{your-paas-token}',
    'oneagent_version'          => '1.217.74.20210504-135638'
  }
)
run_list(
  'recipe[dynatraceoneagent]'
)
```

#### Verify Installer Signature (Linux Only)

Set the `verify_installer_signature` parameter to true if chef should verify the signature of the OneAgent Linux installer script prior to installation. If set to `true`, chef will download the dynatrace root certificate file to the download_dir set value on the managed node. If the verification fails, the recipe will exit with an error code and won't continue with the Dynatrace OneAgent installation.

```ruby
name 'dynatraceoneagent'
description 'Deploy Dynatrace OneAgent'
default_attributes(
  'dynatraceoneagent' => {
    'dynatrace_environment_url'  => 'https://{your-environment-id}.live.dynatrace.com',
    'dynatrace_paas_token'       => '{your-paas-token}',
    'verify_installer_signature' => true,
  }
)
run_list(
  'recipe[dynatraceoneagent]'
)
```

#### Advanced configuration

Download OneAgent installer to a custom directory with additional OneAgent install parameters should be defined as follows (will override default install params):

```ruby
name 'dynatraceoneagent'
description 'Deploy Dynatrace OneAgent'
default_attributes(
  'dynatraceoneagent' => {
    'dynatrace_environment_url'     => 'https://{your-environment-id}.live.dynatrace.com',
    'dynatrace_paas_token'          => '{your-paas-token}',
    'verify_installer_signature'    => true,
    'oneagent_version'              => '1.217.74.20210504-135638'
    'oneagent_download_dir'         => '"C:\\Download Dir"',
    'oneagent_install_params_hash'  => {
        '--set-infra-only'              => 'false',
        '--set-app-log-content-access'  => 'true',
        '--set-host-group'              => 'chef-windows',
        'INSTALL_PATH'                  => '"C:\Program Files"',
    }
  }
)
run_list(
  'recipe[dynatraceoneagent]'
)
```

For Windows, because the parameter `oneagent_download_dir` is a string variable, 2 backslashes are required within the file path. Since the OneAgent install parameter `INSTALL_PATH` can be defined within the `oneagent_install_params_hash` hash map, no escaping is needed.

## Authors

Dynatrace Autonomous Cloud Enablement team (ACE): [ace@dynatrace.com]

## License

Licensed under the MIT License. See the [LICENSE] file for details.


[Dynatrace OneAgent]: https://www.dynatrace.com/support/help/setup-and-configuration/dynatrace-oneagent/
[Supported technologies and versions]: https://www.dynatrace.com/support/help/technology-support/supported-technologies-and-versions/
[Dynatrace Supported Operating Systems]:https://www.dynatrace.com/support/help/technology-support/operating-systems/
[Deployment API]: https://www.dynatrace.com/support/help/extend-dynatrace/dynatrace-api/environment-api/deployment/
[Deployment API - GET available versions of OneAgent]: https://www.dynatrace.com/support/help/dynatrace-api/environment-api/deployment/oneagent/get-available-versions/
[LICENSE]: ./LICENSE
[ace@dynatrace.com]: mailto:ace@dynatrace.com