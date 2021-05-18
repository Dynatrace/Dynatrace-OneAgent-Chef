# Testing

Testing and contributing to this chef cookbook requires the following:

- Chef DK
- Chef Workstation
- VirtualBox

1. Define the required attributes in [kitchen.yml]:

    ```yaml
        attributes:
          dynatraceoneagent:
            dynatrace_environment_url: https://{your-environment-id}.live.dynatrace.com
            dynatrace_paas_token: {your-paas-token}
    ```

1. Run all tests:

    ```bash
    kitchen test
    ```

[kitchen.yml]: ./kitchen.yml