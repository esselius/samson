## Env Plugin
Plugin to manage ENV settings for projects and write .env files during deploy.

Includes `/projects/:permalink/environment?deploy_group=permalink` endpoint that returns the .env content
for a project and deploy_group.

## GitHub to manage environment variables
This plugin has an option to use GitHub repository for .env files.  Using GitHub provides better control
of the environment variables applied to each deploy group and provides the ability to have peer reveiw of 
environment variable changes.  Each project must opt-in to use this feature.

To enable the feature for an instance of Samson add the environment variable DEPLOYMENT_ENV_REPO and set it 
to the the organization and repository that has the .env files.   You should set this in the .env file used
by the samson rails application.
For example:

`DEPLOYMENT_ENV_REPO=my-orgainization/deployment_environmet_config`

The expected structure of this repository is a directory named generated with a sub directory for each 
project samson deploys.  Within this directory for a project are the deploy group .env files using the name
of the deploy group with a `.env` extension.  For example, you may a project named data_processor and 
the deploy groups it can run are staging1 and prod1 and prod2.   Given this structure this feature expects:
```bash
# ls ./
generated
# ls generated/
data_processor
# ls generated/data_processor
staging1.env  prod1.env  prod2.env
```
The contents of the `.env` file is a sequence of environment variable key and value pairs.
```bash
# cat generated/data_processor/staging1.env
MAX_RETRY_ATTEMPTS=10
SECRETE_TOKEN=/secrets/SECRET_TOKEN
RAILS_THREAD_MIN=3
RAILS_THREAD_MAX=5 
```
    