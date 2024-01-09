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