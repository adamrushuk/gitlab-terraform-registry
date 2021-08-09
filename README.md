# gitlab-terraform-registry

Testing GitLab's Terraform Registry feature.

## Publish Terraform Module to GitLab Registry

```bash
# vars
TERRAFORM_MODULE_DIR="module" # The path to your Terraform module
TERRAFORM_MODULE_NAME="test-file" # The name of your Terraform module
TERRAFORM_MODULE_SYSTEM="local" # The system or provider your Terraform module targets (ex. local, aws, google)
TERRAFORM_MODULE_VERSION="0.1.0" # The version of your Terraform module to be published to your project's registry
TERRAFORM_MODULE_FILENAME="${TERRAFORM_MODULE_NAME}-${TERRAFORM_MODULE_SYSTEM}-${TERRAFORM_MODULE_VERSION}.tgz"

# PUT /projects/:id/packages/terraform/modules/:module_name/:module_system/:module_version/file
GITLAB_PROJECT_DEPLOY_TOKEN="<MY_PROJECT_DEPLOY_TOKEN>" # GitLab project deploy token
GITLAB_FQDN="localhost:8082"
GITLAB_API_URL="http://${GITLAB_FQDN}/api/v4/projects/2/packages/terraform/modules/${TERRAFORM_MODULE_NAME}/${TERRAFORM_MODULE_SYSTEM}/${TERRAFORM_MODULE_VERSION}/file"

# compress files
tar -czvf ${TERRAFORM_MODULE_FILENAME} -C ${TERRAFORM_MODULE_DIR} --exclude=./.git .

# publish module using deploy token
curl --header "DEPLOY-TOKEN: ${GITLAB_PROJECT_DEPLOY_TOKEN}" --upload-file ${TERRAFORM_MODULE_FILENAME} ${GITLAB_API_URL}
```

## Use Terraform Module from GitLab Registry

```bash
# vars
TF_CLI_CONFIG_FILE=".terraformrc" # deploy token goes in here

# create credential file
echo -e "credentials \"${GITLAB_FQDN}\" {\n  token = \"$GITLAB_PROJECT_DEPLOY_TOKEN\"\n}" > $TF_CLI_CONFIG_FILE

# init
cd ./test
terraform version
terraform init
```
