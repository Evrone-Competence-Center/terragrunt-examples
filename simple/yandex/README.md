# Provision Yandex Cloud services with Terragrunt

### How to Configure Terraform for Yandex.Cloud

- Install [YC CLI](https://cloud.yandex.com/docs/cli/quickstart)
- Add environment variables for terraform authentication in Yandex.Cloud

```
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

Make sure you setup YC_TOKEN, YC_CLOUD_ID and YC_FOLDER_ID in your environment variables with Github secrets or Gitlab ENV variables

This is a Multi-tenant example.
To setup current tenant, set `TENANT` variable in your environment (CI pipelines too!).

### Configure Terragrunt remote state (S3)

Firstly, create S3 bucket in Yandex Cloud Block storage for terragrunt state storage, eg. `terraform-state-staging`.
Register `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` for your storage in Github secrets or Gitlab ENV variables.

Check bucket name for terraform state storage in `${TENANT}/env.yaml` file:

```yaml
# ${TENANT}/env.yaml
#...
s3:
  bucket: staging-for-example-tf-state
#...
```

### Update terragrunt configuration

In your terminal shell run:

```shell
terragrunt run-all plan
```

to see terragrunt plan.

If you want to apply changes:

```shell
terragrunt run-all apply
```

### Cleanup

To destroy your infrastructure:
```shell
terragrunt run-all destroy
```
And cleanup S3 bucket.