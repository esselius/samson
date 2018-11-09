## Env Plugin
Plugin to manage ENV settings for projects and write .env files during deploy.

Includes `/projects/:permalink/environment?deploy_group=permalink` endpoint that returns the `.env` content
for a project and deploy_group.

## GitHub to manage environment variables
This plugin has an option to use GitHub repository as source for environment variables. Each project must opt-in to 
use this feature.

To enable the feature set the environment variable DEPLOYMENT_ENV_REPO to the organization 
and repository for the deployment environment variables `.env`.  For an
organization named `my_organization` and the repository named `deployment_environment_config` put this in Samson's 
`.env` file:

`DEPLOYMENT_ENV_REPO=my_organization/deployment_environment_config`

The expected structure of this repository is a directory named `generated` with a sub directory for each 
_project permalink_ samson deploys.  Within this directory for a project are the deploy group .env files using the name
of the _deploy group permalink_ with a `.env` extension.  For a project with the permalink `data_processor` and 
the deploy group permalinks `staging1`, `prod1` and `prod2` we expect to see this directory tree:
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
    