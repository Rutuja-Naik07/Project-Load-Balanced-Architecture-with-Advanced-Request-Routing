# scripts

| File | Purpose |
|------|---------|
| `user-data-red.sh` | EC2 user data for the **Red** instance (transcribed from the lab guide). |

## About the Blue script

The **Blue** instance uses the `user-data-blue` file from the lab's
`advanced-request-routing-code.zip`. It follows exactly the same pattern as the Red script
(install Apache, create `/var/www/html/blue`, copy the Blue files from S3), only with the
Blue file names. That zip is course material, so it is **not** included in this repository.

## Before you use a script

1. Replace every `YOUR-BUCKET-NAME` with your real bucket name.
2. Make sure the instance has the `S3-ARR-Role` instance profile attached, otherwise `aws s3 cp` fails.
3. The scripts are written for Amazon Linux (`yum`, `systemctl`).

```bash
# quick replace
sed -i 's/YOUR-BUCKET-NAME/arr-bucket-123456/g' user-data-red.sh
```
