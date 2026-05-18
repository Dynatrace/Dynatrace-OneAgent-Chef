# dynatraceoneagent CHANGELOG

All notable changes to this project will be documented in this file.

# 0.1.0

Initial release.

# 0.2.0

Features

- Ability to download specific version
- Cookbook automatically detects OS and downloads required installer.
- Cookbook automatically detects OS and will install Dynatrace OneAgent with required Chef resource.
- Add support for OneAgent Install Params
- Added parameter to set Dynatrace OneAgent package status
- Added parameter to set Dynatrace OneAgent service status
- Introduced OneAgent installer signature verification functionality
- Add option to delete installer files after successful install.
- Added idempotency

Bugfixes

- Using cookbook specific attributes
- Fixed windows installer

# 0.3.0

Features

- Add possibility to retrieve PaaS token from data bag.