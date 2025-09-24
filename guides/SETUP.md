# SETUP.md

## Prerequisites

Please make sure to share your email with Chanu on Discord (@Chanukya) so you can receive an email invite to the Databricks workspace.

## Mac

Once you've joined the Databricks workspace, you can set up the Databricks CLI with these steps:

1. Install Homebrew (offical documentation [here](https://brew.sh/)).

2. Run

    ```bash
    brew tap databricks/tap
    brew install databricks
    ```

    to install the Databricks CLI at v0.269.0 or newer.

3. Run `databricks auth login`.

4. When prompted for your Databricks profile name, enter the email address you used to join the Databricks workspace.

5. When prompted for your Databricks host:
    1. Go to the Databricks workspace.
    2. Click on `Compute` in the left sidebar.
    3. Click on `Serverless Starter Warehouse` under the `SQL Warehouse` tab.
    4. Click on the `Connection details` tab.
    5. Copy the `OAuth URL` value at the bottom of the tab.
    6. Enter this value as the Databricks host.

You should now see `Profile <email address> was successfully saved` in the command line.

## Windows
